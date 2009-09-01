From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH update] ACPI / PM: Allow PCI root
	bridges to wake	up the system
Date: Tue, 1 Sep 2009 14:25:47 +0100
Message-ID: <20090901132547.GA13084__26720.5598451712$1251811834$gmane$org@srcf.ucam.org>
References: <200908300041.14541.rjw@sisk.pl> <200908312141.00737.rjw@sisk.pl>
	<200908312324.20850.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908312324.20850.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 31, 2009 at 11:24:20PM +0200, Rafael J. Wysocki wrote:

> Updated patch is appended, but there's a problem with it.  Namely, when the
> root bridge GPE is shared with other devices, those devices are also enabled
> to wake up and they may be kind of "interesting" (on one of my test boxes they
> include the ethernet and audio adapters).  I'm not sure what to do about that.

Perhaps only enable it if a child device is enabled? This is difficult 
with the current code - the refcounted GPE stuff I'm working on ought to 
make it easier.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
