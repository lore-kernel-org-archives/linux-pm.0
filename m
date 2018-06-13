From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Subject: Re: [RFC PATCH 06/12] xen-blkfront: add callbacks for PM suspend and
 hibernation
Date: Wed, 13 Jun 2018 10:24:28 +0200
Message-ID: <20180613082428.bjdko4k6cnq6eid3@mac>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-7-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612205619.28156-7-anchalag@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anchal Agarwal <anchalag@amazon.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, netdev@vger.kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, kamatam@amazon.com, fllinden@amazon.com, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 08:56:13PM +0000, Anchal Agarwal wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
> 
> Add freeze and restore callbacks for PM suspend and hibernation support.
> The freeze handler stops a block-layer queue and disconnect the frontend
> from the backend while freeing ring_info and associated resources. The
> restore handler re-allocates ring_info and re-connect to the backedend,
> so the rest of the kernel can continue to use the block device
> transparently.Also, the handlers are used for both PM
> suspend and hibernation so that we can keep the existing suspend/resume
> callbacks for Xen suspend without modification.
> If a backend doesn't have commit 12ea729645ac ("xen/blkback: unmap all
> persistent grants when frontend gets disconnected"), the frontend may see
> massive amount of grant table warning when freeing resources.
> 
>  [   36.852659] deferring g.e. 0xf9 (pfn 0xffffffffffffffff)
>  [   36.855089] xen:grant_table: WARNING: g.e. 0x112 still in use!
> 
> In this case, persistent grants would need to be disabled.
> 
> Ensure no reqs/rsps in rings before disconnecting. When disconnecting
> the frontend from the backend in blkfront_freeze(), there still may be
> unconsumed requests or responses in the rings, especially when the
> backend is backed by network-based device. If the frontend gets
> disconnected with such reqs/rsps remaining there, it can cause
> grant warnings and/or losing reqs/rsps by freeing pages afterward.

I'm not sure why having pending requests can cause grant warnings or
lose of requests. If handled properly this shouldn't be an issue.
Linux blkfront already does live migration (which also involves a
reconnection of the frontend) with pending requests and that doesn't
seem to be an issue.

> This can lead resumed kernel into unrecoverable state like unexpected
> freeing of grant page and/or hung task due to the lost reqs or rsps.
> Therefore we have to ensure that there is no unconsumed requests or
> responses before disconnecting.

Given that we have multiqueue, plus multipage rings, I'm not sure
waiting for the requests on the rings to complete is a good idea.

Why can't you just disconnect the frontend and requeue all the
requests in flight? When the frontend connects on resume those
requests will be queued again.

Thanks, Roger.
