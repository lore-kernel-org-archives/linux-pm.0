From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 11/12] PCI PM: Run-time callbacks for PCI bus
 type (rev. 2)
Date: Wed, 6 Jan 2010 14:06:06 -0800
Message-ID: <20100106140606.0bd3e4fd__47873.7756763168$1262815628$gmane$org@jbarnes-piketon>
References: <200912272057.10443.rjw@sisk.pl> <200912272108.25145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912272108.25145.rjw@sisk.pl>
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
Cc: Oliver@smtp1.linux-foundation.org, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Shaohua@smtp1.linux-foundation.org, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 27 Dec 2009 21:08:24 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce run-time PM callbacks for the PCI bus type.  Make the new
> callbacks work in analogy with the existing system sleep PM
> callbacks, so that the drivers already converted to struct dev_pm_ops
> can use their suspend and resume routines for run-time PM without
> modifications.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Looks good.

-- 
Jesse Barnes, Intel Open Source Technology Center
