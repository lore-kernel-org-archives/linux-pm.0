From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Question about hibernation
Date: Fri, 18 Mar 2011 15:09:02 +0100
Message-ID: <201103181509.02943.oneukum@suse.de>
References: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>
	<201101050927.53977.rjw@sisk.pl>
	<SNT117-W3213A3C4E358A6A690C09BEBB00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <SNT117-W3213A3C4E358A6A690C09BEBB00@phx.gbl>
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
Cc: Raj Kumar <rajkumar278@hotmail.com>
List-Id: linux-pm@vger.kernel.org

Am Freitag, 18. M=E4rz 2011, 14:45:24 schrieb Raj Kumar:
> =

> Hi,
> =

> I have following question regarding the hibernation. If a device driver u=
ses dedicated memory (dedicated memory in linux which is not OS addressable=
 e.g. device driver is using some pages from dedicated memory), When the sy=
stem hibernates, will this be responsibility of device driver to save this =
area =

> or =

> OS hibernation procedure save this area of ram (dedicated memory area) in=
to swap image?

If you got it from get_free_pages (at the end of a long call chain) the
kernel saves it. If not, it is your problem.

	HTH
		Oliver
