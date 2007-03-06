From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 6 Mar 2007 20:03:58 +0800
Message-ID: <b6a2187b0703060403o48130853m9393df70160303c1@mail.gmail.com>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	 <20070226220152.GA29575@stusta.de>
	 <20070228211318.GB4301@mellanox.co.il>
	 <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
	 <20070305000421.GF3441@stusta.de>
	 <b6a2187b0703051732v79a532f6mbf0d3da857a914e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <b6a2187b0703051732v79a532f6mbf0d3da857a914e6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 3/6/07, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> On 3/5/07, Adrian Bunk <bunk@stusta.de> wrote:
>
> > > I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
> > > from RAM, can't suspend to disk. It is possible to revert all the
> > > changes to ACPI and test it?
> >
> > This is with CONFIG_KVM=n?
>
> Yes.

I've tried with CONFIG_KVM=n and CONFIG_KVM=y and both does not suspend.
