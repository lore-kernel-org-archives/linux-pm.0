From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [HELP] Power management for embedded system
Date: Thu, 24 Aug 2006 08:44:25 +0000 (GMT)
Message-ID: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm currently working on a small embedded system based on a MIPS
processor. So far Linux works fine on it and I'd like to implement
power management on this system. For now I realize that APM and ACPI
are implemented by the kernel.

I don't think that ACPI is really suited for what I need. So I took a
look to APM implemetation which seems to be only implemented on i386,
arm and mips architectures. All of these implementations seem to be
based on i386 one. Mips one seems to be a copy and paste of arm one
and both of them have removed all APM bios stuff orginally part of
i386 implementation. It doesn't seem that APM is something really
stable and finished. So now I do not know from where to start...

Is there some other effort in the power management for _embedded_
systems ? I'd like to help in this area and it would be helpful to
know of certain projects that are working in this direction.

thanks

Francis
