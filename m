From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 0/8] mm/kdump: allow to exclude pages that are
 logically offline
Date: Mon, 4 Mar 2019 14:21:18 +0800
Message-ID: <20190304062118.GA31037@dhcp-128-65.nay.redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
 <20190227053214.GA12302@dhcp-128-65.nay.redhat.com>
 <20190228114535.150dfaebbe4d00ae48716bf0@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20190228114535.150dfaebbe4d00ae48716bf0@linux-foundation.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pankaj gupta <pagupta@redhat.com>, Michal Hocko <mhocko@suse.com>, Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org, pv-drivers@vmware.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Omar Sandoval <osandov@fb.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Alexey Dobriyan <adobriyan@gmail.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 02/28/19 at 11:45am, Andrew Morton wrote:
> On Wed, 27 Feb 2019 13:32:14 +0800 Dave Young <dyoung@redhat.com> wrote:
> 
> > This series have been in -next for some days, could we get this in
> > mainline? 
> 
> It's been in -next for two months?

Should be around 3 months

> 
> > Andrew, do you have plan about them, maybe next release?
> 
> They're all reviewed except for "xen/balloon: mark inflated pages
> PG_offline". 
> (https://ozlabs.org/~akpm/mmotm/broken-out/xen-balloon-mark-inflated-pages-pg_offline.patch).
> Yes, I plan on sending these to Linus during the merge window for 5.1
> 

Thanks!
