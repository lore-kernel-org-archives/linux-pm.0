From: david-b@pacbell.net
Subject: Re: [patch 2.6.13-rc5] driver model wakeup support
Date: Wed, 03 Aug 2005 07:07:25 -0700
Message-ID: <20050803140725.493A9DB577@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0508030931290.4886-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77585285233114487=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508030931290.4886-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============77585285233114487==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Date: Wed, 3 Aug 2005 09:37:26 -0400 (EDT)
> From: Alan Stern <stern@rowland.harvard.edu>
>
> Nice to see this finally get into the kernel.

I'll hope ... :)

> The PCI part of this patch should try to use ACPI to identify devices
> capable of platform-specific non-PME wakeup signalling.  I don't have the
> faintest idea how to do this; maybe Len can help.

The same logic that creates /proc/acpi/wakeup will catch
both those non-PME PCI cases and several non-PCI cases.

- Dave


--===============77585285233114487==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77585285233114487==--
