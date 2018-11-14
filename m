From: Gabriel C <nix.or.die@gmail.com>
Subject: Re: atk10k Unknown eventid and WARN() on resume with kernel 4.19
Date: Wed, 14 Nov 2018 23:16:59 +0100
Message-ID: <CAEJqkghgyYMxRc8-wnF-J1CGhuYD2vfVDSiLU1A0fwpXKN7Huw@mail.gmail.com>
References: <CAEJqkgiKzYTZQTGWNAPTeOPFWz658FWqDsAhyoxVDP1VKWSukg@mail.gmail.com>
 <CAEJqkgh7xksO7tmPHGkOXvWftc2AcCgi4j3S3C88CorV53+Hgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAEJqkgh7xksO7tmPHGkOXvWftc2AcCgi4j3S3C88CorV53+Hgw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org
To: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org, dex77@frugalware.org
List-Id: linux-pm@vger.kernel.org

Am Sa., 3. Nov. 2018 um 21:11 Uhr schrieb Gabriel C <nix.or.die@gmail.com>:
>
> Am Sa., 3. Nov. 2018 um 21:01 Uhr schrieb Gabriel C <nix.or.die@gmail.com>:
> >
> > Hello,
> >
> > starting with kernel 4.19 we noticed  'Unknown eventid: xxxx' warnings
> > on our Laptops.
> >
> > ...
> >
> > crazy@devnull:~$ dmesg | grep Unknow
> > [    7.144998] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > [    7.147758] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > [    9.441654] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > [    9.444446] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > [   11.770997] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > [   11.773787] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > [320339.374108] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > [320339.377020] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > [320342.128664] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > [320342.131447] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> > [320344.452864] ath10k_pci 0000:03:00.0: Unknown eventid: 118809
> > [320344.455696] ath10k_pci 0000:03:00.0: Unknown eventid: 90118
> >
> > ....
> >
> > Both boxes also hits the following WARN*() on resume from S3:
> >
>  Uh sorry .. Gmail doesn't like long lines it seems.
> There the WARN() message:
>
> http://ftp.frugalware.org/pub/other/people/crazy/warn.txt
>
> >
> > Please let me know if you need an dmesg or any other informations.


Added pm list maybe someone there got some idea ?

Also same issue reported there :
https://bugzilla.kernel.org/show_bug.cgi?id=201499

BR,

Gabriel C
