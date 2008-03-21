From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [ugly patch] Save .15W-.5W by AHCI powersaving
Date: Fri, 21 Mar 2008 08:49:56 +0100
Message-ID: <200803210849.58035.oliver@neukum.org>
References: <20080225134558.GA1611@elf.ucw.cz> <47C34081.5090205@rtr.ca>
	<47C34472.3090706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47C34472.3090706@garzik.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>
List-Id: linux-pm@vger.kernel.org

Am Montag, 25. Februar 2008 23:42:58 schrieb Jeff Garzik:
> > This is cool enough that we really ought to do a hardware-independent
> > version, so that all SATA interfaces could benefit. =A0Especially ata_p=
iix,
> > but others too.
> =

> BTW we can also save power by allowing the user to choose to disable =

> hotplugging support. =A0Then we can power down PHYs that are not in use.

Can't we power them up periodically to check for new hardware?

	Regards
		Oliver
