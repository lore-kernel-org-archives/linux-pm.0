From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH 2/2] swsusp: improve freeing of
	memory
Date: Thu, 10 Nov 2005 11:12:46 +0100
Message-ID: <200511101112.47139.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl> <200511092338.49034.rjw@sisk.pl>
	<20051109231544.GI12459@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109231544.GI12459@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 10 of November 2005 00:15, Pavel Machek wrote:
> Hi!
> 
> > > For console users, it may be preferable... 
> > 
> > Well, that depends on what the user is doing in general, but do you have
> > any specific scenario in mind?
> 
> Well, when I'm working on console, little latency does not hurt. I
> can't work at all while system is reading image, but I can work quite
> well while system is swapping in... on the console, that is.

OK, so do you want a kconfig option for switching on the "free as much
memory as you can" behavior then?

Rafael
