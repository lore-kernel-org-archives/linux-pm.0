From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 23:12:48 +0100
Message-ID: <200902162312.50556.rjw__28730.036415118$1234822631$gmane$org@sisk.pl>
References: <200902160010.16955.rjw@sisk.pl> <200902162248.34287.rjw@sisk.pl>
	<20090216135339.53b4a911@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216135339.53b4a911@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Arjan van de Ven wrote:
> On Mon, 16 Feb 2009 22:48:32 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > Userland should never ever control the state of a device like this
> > > directly. It should do so by a) closing the device and b) setting
> > > latency / functional requirements.
> > 
> > The user, however, may want to forcibly put a device into a low power
> > state without stopping all of the applications that depend on it (eg.
> > have it open). Do you think that we shouldn't allow users to do such
> > things?
> 
> I would think that that is a bad mistake to do. It basically breaks the 
> contract that the kernel has with userspace.... 

OK, so I think there are two things that user space may be allowed to do as
far as putting devices into low power states is concerned:
* disable/enable the automatic power management of the device (provided that
  the driver supports the automatic PM)
* check what power states devices are in.

Thanks,
Rafael
