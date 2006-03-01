From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Order of suspension for pcmcia based usb host
	controller
Date: Wed, 1 Mar 2006 10:32:14 +0100
Message-ID: <20060301093214.GC9960@isilmar.linta.de>
References: <380D9721A8E2114485644D71E87C6AB20169F10E@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22726719250425198=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20169F10E@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============22726719250425198==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2006 at 06:15:26PM +0530, rasmit.ranjan@wipro.com wrote:
> In my pcmcia client driver i get suspend event when i do selective
> suspend of the card (pcmcia-socket1/device in device tree ) .  Platform
> driver`s suspend entry point is getting called when i do selective
> suspend of myhcd. Now if i do global suspend will Power Management
> sub-system follow the device tree to suspend the card ? Which means PM
> sub-system will suspend 5-0:1.0 , then it will suspend usb5, then myhcd
> and then the pcmcia-socket1/device. So does it mean that in global
> suspend platform driver`s suspend entry point will be getting called
> before the pcmcia client driver`s suspend event ?  

AFAIK the "children" (clients) will be called first, then the "parents"
(socket driver).

	Dominik

--===============22726719250425198==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22726719250425198==--
