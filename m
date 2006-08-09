From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 22:32:03 +0200
Message-ID: <200608092232.03360.rjw@sisk.pl>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<200608091415.51226.rjw@sisk.pl>
	<Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, ncunningham@linuxmail.org, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 August 2006 15:16, Steven Rostedt wrote:
> =

> On Wed, 9 Aug 2006, Rafael J. Wysocki wrote:
> =

> >
> > If it's a P4, we rather don't, because the ACPI tables should be above =
the
> > last pfn in the normal zone.  Still, Steven please send your dmesg afte=
r a
> > fresh boot.
> >
> =

> Attached is a gzipped version of my dmesg.

Thanks.

I don't think we overwrite anything important from the hardware's perspecti=
ve.

Rafael
