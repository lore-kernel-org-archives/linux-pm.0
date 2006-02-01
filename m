From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] pm_prepare_console in
	drivers/macintosh/via-pmu.c
Date: Thu, 02 Feb 2006 09:36:47 +1100
Message-ID: <1138833408.4934.51.camel@localhost.localdomain>
References: <200602010831.48000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37997316312562912=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602010831.48000.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============37997316312562912==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-02-01 at 08:31 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> The drivers/macintosh/via-pmu.c driver is the only user of pm_prepare_console()
> and pm_restore_console() calls outside of kernel/power.  If it is going to stay like
> that we should move the new #ifdef around the declarations of
> pm_prepare_console() and pm_restore_console() as well as the definition
> of SUSPEND_CONSOLE from kernel/power/power.h to include/linux/suspend.h,
> unless CONFIG_VT and CONFIG_VT_CONSOLE are always set on Macs.

They should always be set...

Ben.



--===============37997316312562912==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37997316312562912==--
