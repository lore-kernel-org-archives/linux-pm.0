From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Mon, 27 Oct 2008 12:37:53 +0100
Message-ID: <E1KuQPx-0002Yz-7K__47213.3148149171$1225119275$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810262101.08822.rjw@sisk.pl>
	<E1KuQ1J-0002Vw-9Q@pomaz-ex.szeredi.hu>
	<1225106427.26724.5.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1225106427.26724.5.camel@nigel-laptop> (message from Nigel
	Cunningham on Mon, 27 Oct 2008 22:20:27 +1100)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ncunningham@crca.org.au
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Oct 2008, Nigel Cunningham wrote:
> It doesn't matter why a process is sitting in that wait_event call. What
> does matter is that one can be there.

Right, but it could also be sleeping in any other wait_event(),
mutex_lock(), etc, resulting in the same issue.

> No, it's part of the solution. I haven't posted the full fuse freezing
> patch because I thought this could be profitably merged without the rest
> of the patch.

Please post the full patch, it'd be a lot better to see the big
picture instead of just a small part of it.

Thanks,
Miklos
