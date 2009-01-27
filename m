From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/3] PCI PM: Fix hibernation breakage on
	EeePC 701
Date: Tue, 27 Jan 2009 09:49:26 -0800
Message-ID: <200901270949.27012.jbarnes__20808.51090509$1233079179$gmane$org@virtuousgeek.org>
References: <200901222335.07341.rjw@sisk.pl> <200901222336.56573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901222336.56573.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-pm@vger.kernel.org

On Thursday, January 22, 2009 2:36 pm Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Hibernation breaks on EeePC 701 as a result of attempting to put one
> of its (driverless) devices into a low power state.  Avoid that by
> not attepmting to power manage driverless devices during hibernation.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-and-tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Applied this series to my for-linus branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
