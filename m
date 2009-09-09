From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH 1/5] PCI PM: Simplify PCI wake-up code
Date: Wed, 9 Sep 2009 14:20:20 -0700
Message-ID: <20090909142020.334a9e84__1760.92931437797$1252531384$gmane$org@jbarnes-g45>
References: <200908300041.14541.rjw@sisk.pl> <200909040002.02562.rjw@sisk.pl>
	<200909082311.48366.rjw@sisk.pl> <200909082312.59769.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909082312.59769.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ykzhao <yakui.zhao@intel.com>, Matthew@smtp1.linux-foundation.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Sep 2009 23:12:59 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Rework the PCI wake-up code so that it's easier to read without
> changing the functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Applied this series to my linux-next branch, thanks.  Len, that include
the ACPI portion; hope that's ok.

-- 
Jesse Barnes, Intel Open Source Technology Center
