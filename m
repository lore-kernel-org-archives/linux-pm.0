From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/6] swsusp: rework swsusp_suspend
Date: Sun, 30 Oct 2005 00:25:00 +0200
Message-ID: <20051029222500.GB14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292201.05724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55064947081185855=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510292201.05724.rjw@sisk.pl>
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
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============55064947081185855==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This is a preliminary step.  It makes only the functions in swsusp.c call
> functions in snapshot.c and not both ways.  Basically, it moves the code
> without changing its functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK, nice.
								Pavel
-- 
Thanks, Sharp!

--===============55064947081185855==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55064947081185855==--
