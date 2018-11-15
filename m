From: Gabriel C <nix.or.die@gmail.com>
Subject: Re: atk10k Unknown eventid and WARN() on resume with kernel 4.19
Date: Thu, 15 Nov 2018 02:06:47 +0100
Message-ID: <CAEJqkgiz0-5m5uDUW2vzCatxHPX2Gi6oPQwR_J5Y4fV8iuiguw@mail.gmail.com>
References: <CAEJqkgiKzYTZQTGWNAPTeOPFWz658FWqDsAhyoxVDP1VKWSukg@mail.gmail.com>
 <CAEJqkgh7xksO7tmPHGkOXvWftc2AcCgi4j3S3C88CorV53+Hgw@mail.gmail.com> <CAEJqkghgyYMxRc8-wnF-J1CGhuYD2vfVDSiLU1A0fwpXKN7Huw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEJqkghgyYMxRc8-wnF-J1CGhuYD2vfVDSiLU1A0fwpXKN7Huw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>, Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, dex77@frugalware.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Am Mi., 14. Nov. 2018 um 23:16 Uhr schrieb Gabriel C <nix.or.die@gmail.com>:
> > > Hello,
> > >
> > > starting with kernel 4.19 we noticed  'Unknown eventid: xxxx' warnings
> > > on our Laptops.
> > >
> > > ...
> > >
> > > crazy@devnull:~$ dmesg | grep Unknow
> > > [    7.144998] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > > [    7.147758] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > > [    9.441654] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > > [    9.444446] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > > [   11.770997] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > > [   11.773787] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > > [320339.374108] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > > [320339.377020] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > > [320342.128664] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > > [320342.131447] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > > [320344.452864] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > > [320344.455696] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > >
> > > ....
> > >
> > > Both boxes also hits the following WARN*() on resume from S3:
> > >
> >  Uh sorry .. Gmail doesn't like long lines it seems.
> > There the WARN() message:
> >
> > http://ftp.frugalware.org/pub/other/people/crazy/warn.txt
> >
> > >
> > > Please let me know if you need an dmesg or any other informations.
>
>
> Added pm list maybe someone there got some idea ?
>
> Also same issue reported there :
> https://bugzilla.kernel.org/show_bug.cgi?id=201499
>

The WARN_ON() on resume seems to be triggered  after commit cd93b83ad927b.

BR,

Gabriel C
