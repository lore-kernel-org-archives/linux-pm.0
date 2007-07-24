From: "Huang, Ying" <ying.huang@intel.com>
Subject: RE: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Tue, 24 Jul 2007 22:00:04 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC236CF66__27402.4868304425$1185285661$gmane$org@pdsmsx415.ccr.corp.intel.com>
References: <200707151249.26148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200707151249.26148.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

>From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>This is not the point.  There are memory regions that you should not
_restore_,
>because that will cause harm.
>
>> On x86_64, there is another usage of nosave during processing E820
>> memory map. But I don't know why the memory region other than
E820_RAM
>> are marked as nosave. I think only the memory region of type E820_RAM
>> will be thought of normal memory, others will be thought as reserved.
Is
>> it sufficient just to check whether the page is reserved?
>
>No, it's not.

The "/proc/iomem" records information of all memory regions including
"normal RAM" and all kinds of reserved regions, which is backed by
iomem_resource. On x86_64, it is initialized in the exact same way as
nosave region initialization.

I think maybe we can replace the "nosave region" concepts with
"iomem_resource" (maybe need some enhancement).

Best Regards,
Huang Ying
