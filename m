From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 15:58:49 +0200
Message-ID: <200906081558.49860.oliver__38984.4296071262$1244469538$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608133215.GA15482@srcf.ucam.org>
	<20090608134647.GA14234@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608134647.GA14234@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 8. Juni 2009 15:46:47 schrieb Ingo Molnar:
> ( Providing a way to _override_ those defaults is of course natural,
> =A0 via /sysfs, should the user express an interest in tweaking it, or
> =A0 should the kernel get it so wrong that a distro wants to work it
> =A0 around. But your argument seems to be "push configuration and
> =A0 handling into user-space" which is really backwards. )

If we agree that the default shall be that the kernel doesn't switch
off features of the hardware for power saving by default, does this
make a practical difference to keeping the configuration in user space?

	Regards
		Oliver
