From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH 2/2] swsusp: improve freeing of
	memory
Date: Thu, 10 Nov 2005 00:15:44 +0100
Message-ID: <20051109231544.GI12459@elf.ucw.cz>
References: <200511082355.43984.rjw@sisk.pl> <200511090011.53125.rjw@sisk.pl>
	<20051109144647.GA1909@elf.ucw.cz> <200511092338.49034.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57343369882016659=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511092338.49034.rjw@sisk.pl>
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

--===============57343369882016659==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > For console users, it may be preferable... 
> 
> Well, that depends on what the user is doing in general, but do you have
> any specific scenario in mind?

Well, when I'm working on console, little latency does not hurt. I
can't work at all while system is reading image, but I can work quite
well while system is swapping in... on the console, that is.

In X, userland is needed for switching windows etc, and that makes
"work while swapping-in" painfull.

								Pavel
-- 
Thanks, Sharp!

--===============57343369882016659==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============57343369882016659==--
