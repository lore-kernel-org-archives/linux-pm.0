From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] pm_prepare_console in
	drivers/macintosh/via-pmu.c
Date: Thu, 2 Feb 2006 00:08:25 +0100
Message-ID: <200602020008.26058.rjw@sisk.pl>
References: <200602010831.48000.rjw@sisk.pl>
	<1138833408.4934.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31984469795275716=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1138833408.4934.51.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============31984469795275716==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 01 February 2006 23:36, Benjamin Herrenschmidt wrote:
> On Wed, 2006-02-01 at 08:31 +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The drivers/macintosh/via-pmu.c driver is the only user of pm_prepare_console()
> > and pm_restore_console() calls outside of kernel/power.  If it is going to stay like
> > that we should move the new #ifdef around the declarations of
> > pm_prepare_console() and pm_restore_console() as well as the definition
> > of SUSPEND_CONSOLE from kernel/power/power.h to include/linux/suspend.h,
> > unless CONFIG_VT and CONFIG_VT_CONSOLE are always set on Macs.
> 
> They should always be set...

So no changes are needed. :-)

Thanks,
Rafael

--===============31984469795275716==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31984469795275716==--
