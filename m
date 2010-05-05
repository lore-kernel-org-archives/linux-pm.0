From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 20:28:11 +0100
Message-ID: <20100505192811.GA5468__44942.6551269882$1273090457$gmane$org@srcf.ucam.org>
References: <20100505190758.GG7139@rakim.wolfsonmicro.main>
	<Pine.LNX.4.44L0.1005051515060.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005051515060.1885-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 03:20:40PM -0400, Alan Stern wrote:

> One the face of it, a runtime-PM solution would dictate that the
> codec's driver ought to turn off the codec whenever the driver thinks
> it isn't being used.  Ergo, if the driver didn't know when a call was
> in progress, it would use runtime PM to turn off the codec during a
> call.

Well, part of the problem is that right now most of our beliefs about 
imposed constraints tend to be based on what userspace is doing - "Don't 
power down the audio codec when userspace has it open", for instance. 
But that goes away with opportunistic suspend. In most cases you don't 
want the audio codec to stay awake just because userspace was using it 
to make bouncing cow noises, especially if you've just frozen userspace. 
So the problem becomes more complicated than it would otherwise be.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
