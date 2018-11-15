From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Date: Thu, 15 Nov 2018 15:13:07 +0100
Message-ID: <20181115141307.GH26448@zn.tnic>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-4-david@redhat.com>
 <20181115061923.GA3971@dhcp-128-65.nay.redhat.com>
 <20181115111023.GC26448@zn.tnic>
 <4aa5d39d-a923-87de-d646-70b9cbfe62f0@redhat.com>
 <20181115115213.GE26448@zn.tnic>
 <20181115121102.GP23831@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20181115121102.GP23831@dhcp22.suse.cz>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Omar Sandoval <osandov@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lianbo Jiang <lijiang@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 15, 2018 at 01:11:02PM +0100, Michal Hocko wrote:
> I am not familiar with kexec to judge this particular patch but we
> cannot simply define any range for these pages (same as for hwpoison
> ones) because they can be almost anywhere in the available memory range.
> Then there can be countless of them. There is no other way to rule them
> out but to check the page state.

I guess, especially if it is a monster box with a lot of memory in it.

> I am not really sure what is the concern here exactly. Kdump is so
> closly tight to the specific kernel version that the api exported
> specifically for its purpose cannot be seriously considered an ABI.
> Kdump has to adopt all the time.

Right...

Except, when people start ogling vmcoreinfo for other things and start
exporting all kinds of kernel internals in there, my alarm bells start
ringing.

But ok, kdump *is* special and I guess that's fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
