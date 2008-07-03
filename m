From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 4/4] x86_32: mark ACPI NVS memory region
Date: Thu, 3 Jul 2008 10:27:20 +0200
Message-ID: <20080703082720.GA4389@elte.hu>
References: <1215051879.5628.36.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1215051879.5628.36.camel@rzhang-dt.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Zhang Rui <rui.zhang@intel.com> wrote:

> 
> x86_32: Mark ACPI NVS memory region.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  arch/x86/kernel/e820_32.c |   26 ++++++++++++++++++++++++++

please do this change against tip/master or linux-next, as this file has 
been heavily modified and unified already. See:

 http://people.redhat.com/mingo/tip.git/README

	Ingo
