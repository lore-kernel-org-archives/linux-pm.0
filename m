From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.14 suspend fails with "Strange,
	firmware/dell_r not stopped"
Date: Thu, 10 Nov 2005 11:12:59 +0100
Message-ID: <20051110101259.GE2021@elf.ucw.cz>
References: <436F3609.2050907@naurel.org> <20051109214807.GC12459@elf.ucw.cz>
	<4372C198.8010506@naurel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============021569837477665388=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <4372C198.8010506@naurel.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurel@naurel.org>
Cc: linux-pm@osdl.org, abhay_salunke@dell.com
List-Id: linux-pm@vger.kernel.org

--===============021569837477665388==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Another issue is that the rbu driver updates the bios, once it is
> configured with the new binary it's probably unsafe to suspend because
> the kernel will resume on a different bios, i don't know much of
> the kernel/bios interactions but i guess it could be a buggy situation...

Yes, I'd prefer not to suspend in this case.
									Pavel

-- 
Thanks, Sharp!

--===============021569837477665388==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============021569837477665388==--
