From: David Brownell <david-b@pacbell.net>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Tue, 17 May 2005 11:35:09 -0700
Message-ID: <200505171135.09928.david-b@pacbell.net>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<200505161726.42479.david-b@pacbell.net>
	<200505171110.47030.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43906072487872683=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505171110.47030.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============43906072487872683==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 17 May 2005 2:10 am, Rafael J. Wysocki wrote:

> Could you please have a look at http://bugzilla.kernel.org/show_bug.cgi?id=4416

Sorry, I don't have much time for such things; especially for
problems that only appear in the MM tree (with so many non-USB
changes) ... and which already appear to be board-specific, and
tied to ACPI changes.


> There seems to be a problem with OHCI and EHCI drivers wrt suspend/resume
> (swsusp) in the current -mm on that box.

Is that with or without those ACPI fixes?

- Dave

--===============43906072487872683==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43906072487872683==--
