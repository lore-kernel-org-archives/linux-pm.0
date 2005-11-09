From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH 2/2] swsusp: improve freeing of
	memory
Date: Wed, 9 Nov 2005 23:38:48 +0100
Message-ID: <200511092338.49034.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl> <200511090011.53125.rjw@sisk.pl>
	<20051109144647.GA1909@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109144647.GA1909@elf.ucw.cz>
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

On Wednesday, 9 of November 2005 15:46, Pavel Machek wrote:
> Hi!
> 
> > This patch makes swsusp free only as much memory as needed and not as much
> > as possible.
> 
> Is there a way to get old behaviour (== free as much memory as
> possible)?

Not really.  At least not in this patch.  In principle I can add a kconfig
option for that ...

> For console users, it may be preferable... 

Well, that depends on what the user is doing in general, but do you have
any specific scenario in mind?

Rafael
