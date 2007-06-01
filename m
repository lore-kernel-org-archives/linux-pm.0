From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Fri, 1 Jun 2007 22:37:16 +0200
Message-ID: <200706012237.17375.rjw__45102.7611540214$1180729938$gmane$org@sisk.pl>
References: <878xb35sje.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <878xb35sje.fsf@goat.bogus.local>
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
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, 1 June 2007 22:27, Olaf Dietsche wrote:
> Hi,
> 
> resume from suspend to ram doesn't work for my laptop and never
> has. So, this is not a regression.
> 
> Hibernate (aka suspend to disk) works, however.
> 
> When I resume, everything seems to come up (fan becomes busy, disk and
> dvd spin up for a short time),

Hmm, what about the screen?

Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
