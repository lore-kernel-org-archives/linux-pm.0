From: "Scott Thompson" <postfail@hushmail.com>
Subject: Re: [RFC] CONFIG_PM_LEGACY = compiler warnings for
	deprecation ... solution?
Date: Wed, 01 Aug 2007 09:53:31 -0400
Message-ID: <20070801135332.7977F22825__43896.812949288$1185983641$gmane$org@mailserver9.hushmail.com>
Reply-To: postfail@hushmail.com
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On Wed, 01 Aug 2007 06:57:25 -0400 "Rafael J. Wysocki" 
<rjw@sisk.pl> wrote:
>We are going to remove the legacy PM altogether, AFAICS, although 
>there still
>are some obstacles.
>

Thanks -- I had checked Documentation/feature_removal_schedule.txt 
for this, but looks like the obsoletion is referenced in 
Documentation/pm.txt.

I'll offer to patch in the solution I proposed to prevent the 
compile warnings in the interim if you're interested...

---------------------------------------
Scott Thompson / postfail@hushmail.com
---------------------------------------

--
Click to compare mortgage rates.  No obligation, quick and easy.
http://tagline.hushmail.com/fc/Ioyw6h4d9W9hXcSp6ap42rYth9zHy4WFLKyuhpeBgrAsHklUj07kVn/
