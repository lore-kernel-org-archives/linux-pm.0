From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Metrics for comparing power savings of patches...
Date: Sun, 16 Mar 2008 20:03:42 +0100
Message-ID: <20080316190341.GA4638@ucw.cz>
References: <20080307170105.AF99E1A0039@mailserver8.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080307170105.AF99E1A0039@mailserver8.hushmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Scott Thompson <postfail@hushmail.com>
Cc: linux-pm@lists.linux-foundation.org, power@bughost.org
List-Id: linux-pm@vger.kernel.org

On Fri 2008-03-07 12:01:05, Scott Thompson wrote:
> I've seen several patch submissions and comments with varying
> claims of 'power savings' from one level to another on both the 
> linux-pm and powertop lists.
> 
> Standard technique seems to be to plug computer directly into a
> wattmeter and then provide some feedback as to the savings comparing
> one patchgroup to what is currently available.
> 
> Different wattmeters, however, will have different response and 
> accuracy depending on load for instant readings; usually the lower-
> loads (such as laptops) will be less accurate.

notebooks usually have internal wattmeters. cat /proc/acpi/batt*/*/*.

> However, I have seen that most wattmeters do a 'better' job at 
> measuring total wattage over an interval than the 'instant 
> reading'. I advise caution in advertising 'expected savings' for 
> instant readings....
> 
> Also, if anyone knows of any free benchmarks, best practices, or 
> guidelines for trying to do comparative power analysis for patches 
> with wattmeters please let me know.

Intel has something on lesswatts.org.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
