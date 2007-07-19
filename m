From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Thu, 19 Jul 2007 11:13:21 +0200
Message-ID: <200707191113.22711.rjw__43600.7431628697$1184836120$gmane$org@sisk.pl>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070718180420.02352d4f.akpm@linux-foundation.org>
	<1184827403.15756.14.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184827403.15756.14.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 19 July 2007 08:43, Huang, Ying wrote:
> On Wed, 2007-07-18 at 18:04 -0700, Andrew Morton wrote:
> > I like the idea but I think I'll let people chat about it a bit more
> > before looking at merging the patches, OK?
> 
> I think maybe we should wait for Rafael to separate the device hibernate
> (quiesce and state save) from device suspend.

Well, I'm afraid that will take some time ...

> Without that, the ACPI issue can not be resolved.

Yes, it seems so.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
