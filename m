From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/10] mm: Introduce the memory regions data
	structure
Date: Fri, 27 May 2011 08:30:03 -0700
Message-ID: <1306510203.22505.69.camel__17133.1652942628$1306876368$gmane$org@nimitz>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<1306499498-14263-2-git-send-email-ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306499498-14263-2-git-send-email-ankita@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ankita Garg <ankita@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-05-27 at 18:01 +0530, Ankita Garg wrote:
> +typedef struct mem_region_list_data {
> +       struct zone zones[MAX_NR_ZONES];
> +       int nr_zones;
> +
> +       int node;
> +       int region;
> +
> +       unsigned long start_pfn;
> +       unsigned long spanned_pages;
> +} mem_region_t;
> +
> +#define MAX_NR_REGIONS    16 

Don't do the foo_t thing.  It's out of style and the pg_data_t is a
dinosaur.

I'm a bit surprised how little discussion of this there is in the patch
descriptions.  Why did you choose this structure?  What are the
downsides of doing it this way?  This effectively breaks up the zone's
LRU in to MAX_NR_REGIONS LRUs.  What effects does that have?

How big _is_ a 'struct zone' these days?  This patch will increase their
effective size by 16x.

Since one distro kernel basically gets run on *EVERYTHING*, what will
MAX_NR_REGIONS be in practice?  How many regions are there on the
largest systems that will need this?  We're going to be doing many
linear searches and iterations over it, so it's pretty darn important to
know.  What does this do to lmbench numbers sensitive to page
allocations?

-- Dave
