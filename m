From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] suspend.c: make sure stdin,
	stdout and stderr are open
Date: Mon, 10 Apr 2006 08:58:19 +0200
Message-ID: <20060410065819.GB21706@suse.de>
References: <200603242013.48811.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200603242013.48811.stefan@loplof.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 24, 2006 at 08:13:48PM +0100, Stefan Rompf wrote:
> Hi,
>=20
> recently I patched my 2.6.16 kernel to use uswsusp. Nice work, but when=
 I=20
> installed /usr/local/sbin/suspend into the Suse 9.3 powermanagement scr=
ipts,=20
> I've stumbled over a bad interaction: powersaved closes all filedescrip=
tors=20
> before calling scripts. suspend then opens snapshot and swap device,=20

FWIW, i will also adress this in powersaved. More programs will run into
the same trap probably ;-)
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohe=
n
