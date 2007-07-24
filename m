From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Tue, 24 Jul 2007 17:27:34 +0200
Message-ID: <200707241727.35589.rjw__26584.2809611515$1185291055$gmane$org@sisk.pl>
References: <9D7649D18729DE4BB2BD7B494F7FEDC236CF66@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9D7649D18729DE4BB2BD7B494F7FEDC236CF66@pdsmsx415.ccr.corp.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 24 July 2007 16:00, Huang, Ying wrote:
> >From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> >This is not the point.  There are memory regions that you should not
> _restore_,
> >because that will cause harm.
> >
> >> On x86_64, there is another usage of nosave during processing E820
> >> memory map. But I don't know why the memory region other than
> E820_RAM
> >> are marked as nosave. I think only the memory region of type E820_RAM
> >> will be thought of normal memory, others will be thought as reserved.
> Is
> >> it sufficient just to check whether the page is reserved?
> >
> >No, it's not.
> 
> The "/proc/iomem" records information of all memory regions including
> "normal RAM" and all kinds of reserved regions, which is backed by
> iomem_resource. On x86_64, it is initialized in the exact same way as
> nosave region initialization.
> 
> I think maybe we can replace the "nosave region" concepts with
> "iomem_resource" (maybe need some enhancement).

Yes, I think that might be done.

Geetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
