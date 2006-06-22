From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Suspend to disk not working with PCMCIA card
Date: Thu, 22 Jun 2006 19:44:33 +0200
Message-ID: <20060622174433.GA10138@dominikbrodowski.de>
References: <380D9721A8E2114485644D71E87C6AB2020F3518@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <380D9721A8E2114485644D71E87C6AB2020F3518@PNE-HJN-MBX01.wipro.com>
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

Hi,

On Wed, Jun 21, 2006 at 07:05:45PM +0530, rasmit.ranjan@wipro.com wrote:
> My laptop goes into suspended state.Then i press the power button and my
> laptop resumed properly.
> But this does not work while a PCMCIA card is plugged in. In the first
> case my laptop does not go into suspended mode. My screen becomes blank
> and LCD of the PCMCIA card remains on. To use my laptop i had to reboot
> it. What might be the problem ? =


That seems to be the uevent / call_usermodehelper breakage still being
present ... see the list archives for January for a more detailled
description of the problem; unfortunately, I haven't had the time to tackle
this problem more closely so far.

	Dominik
