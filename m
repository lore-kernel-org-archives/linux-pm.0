From: Andrew Morton <akpm@osdl.org>
Subject: Re: resume from S3 regression [Was: 2.6.18-rc3-mm2]
Date: Mon, 7 Aug 2006 13:02:08 -0700
Message-ID: <20060807130208.94b58773.akpm@osdl.org>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<20060807193836.GA4007@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932335AbWHGUCa@vger.kernel.org>
In-Reply-To: <20060807193836.GA4007@inferi.kami.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Aug 2006 21:38:36 +0200
Mattia Dongili <malattia@linux.it> wrote:

> after resume from ram (tested in single user), I can type commands for a
> few seconds (time is variable), the processes get stuck in io_schedule.
> Poorman's screenshots are here:
> http://oioio.altervista.org/linux/dsc03448.jpg
> http://oioio.altervista.org/linux/dsc03449.jpg

That probably measn that the device or device driver has got itself into a
sick state and IO completions aren't occurring. 

Which storage device (and which device driver) is being used here?
