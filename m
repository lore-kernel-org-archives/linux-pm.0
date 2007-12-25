From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: ACPI: _PTS ordering needs fixing for pre ACPI 3.0
	systems (was: Re: x86: Increase PCIBIOS_MIN_IO to 0x1500 to
	fix nForce 4 suspend-to-RAM)
Date: Tue, 25 Dec 2007 13:52:11 +0000
Message-ID: <200712251352.13902.carlos__29985.6911683039$1198781855$gmane$org@strangeworlds.co.uk>
References: <fa.Tr7qmPdet0rF2FSRX/94s2UEMSE@ifi.uio.no>
	<200712251436.52246.rjw@sisk.pl> <200712251507.24144.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712251507.24144.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 December 2007 14:07:22 Rafael J. Wysocki wrote:
> OK, sorry, the approach is generally reasonable, IMO, but it needs to be a
> bit more fine grained.

I know, hence this was marked as a hack and not signed off; it's just a 
demonstration of the general idea with code instead of words.

> I'll try to prepare some patches along these lines soon.

Much appreciated - I'm much happier with someone who's more familiar with this 
code than I working on it.

-Carlos

(Now going back to unwrapping Christmas presents...)
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
