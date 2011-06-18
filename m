From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Fri, 17 Jun 2011 21:08:56 -0700
Message-ID: <20110617210856.1dd3b482__44993.0994226181$1308373349$gmane$org@infradead.org>
References: <20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
	<20110610180807.GB28500@srcf.ucam.org>
	<20110610184738.GG2230@linux.vnet.ibm.com>
	<20110610192329.GA30496@srcf.ucam.org>
	<20110610193713.GJ2230@linux.vnet.ibm.com>
	<20110610200233.5ddd5a31@infradead.org>
	<20110615165321.GC23151@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110615165321.GC23151@in.ibm.com>
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
Cc: Kyungmin Park <kmpark@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 15 Jun 2011 22:23:21 +0530
Ankita Garg <ankita@in.ibm.com> wrote:

> The maximum order in buddy allocator is by default 1k pages. Isn't
> this too small a granularity to track blocks that might comprise a
> PASR unit? 

we had to bump the default up a little, but not all that much

(like 4x)
