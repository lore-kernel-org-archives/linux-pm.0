From: David Brownell <david-b@pacbell.net>
Subject: Re: Question about suspending a system
Date: Wed, 17 Oct 2007 10:43:51 -0700
Message-ID: <20071017174351.81D6A236029@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
	<1192464239.3349.57.camel@johannes.berg>
	<20071015164159.3273923A692@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<38b2ab8a0710160649r5085d5ccs3a7e298bbde7867a@mail.gmail.com>
	<20071016173119.5266C23BD7D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<38b2ab8a0710170525g5a4736e4xc9c1c3420ed488fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <38b2ab8a0710170525g5a4736e4xc9c1c3420ed488fa@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: francis.moro@gmail.com
Cc: linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net
List-Id: linux-pm@vger.kernel.org

> > Most of the systems I've worked with don't have rotating media, unless
> > someone sticks a MicroDrive into a CF slot.
>
> Even a hard drive connected through USB ?

Well, I meant "embedded" systems ... given that, yes.

For that matter, rotating media on USB drives generally
need more than the 500 mA max power available through USB.
They need independant power supplies.  So their power
management doesn't really kick in with system suspend.

- Dave
