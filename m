From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 03/10] threadgroup: extend threadgroup_lock()
 to cover exit and exec
Date: Wed, 23 Nov 2011 15:34:53 +0100
Message-ID: <20111123143444.GA14549__39325.362785212$1322058925$gmane$org@somewhere.redhat.com>
References: <1320191193-8110-1-git-send-email-tj@kernel.org>
	<1320191193-8110-4-git-send-email-tj@kernel.org>
	<20111113164426.GB9446@somewhere> <20111114135404.GD9446@somewhere>
	<20111121220326.GM25776@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111121220326.GM25776@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-pm@lists.linux-foundation.org, paul@paulmenage.org, kamezawa.hiroyu@Jp.fujitsu.com
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2011 at 02:03:26PM -0800, Tejun Heo wrote:
> On Mon, Nov 14, 2011 at 02:54:08PM +0100, Frederic Weisbecker wrote:
> > > Also note this is currently protected by the tasklist readlock. Cred guard mutex is
> > > certainly better, I just don't remember if you remove the tasklist lock in a
> > > further patch.
> > 
> > Ah recalling what Ben Blum said, we also need the leader to stay stable because it
> > is excpected to be passed in ->can_attach(), ->attach(), ->cancel_attach(), ...
> > Although that's going to change after your patches that pass a flex array.
> 
> Not really without locking out exec.  The thing is whoever is exec'ing
> will be the leader and we can't guarantee that the first in the flex
> array is always the leader.  One method may see it as the leader, the
> next one might not.

Exactly!
