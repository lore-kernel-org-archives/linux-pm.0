From: "Scott Thompson" <postfail@hushmail.com>
Subject: Metrics for comparing power savings of patches...
Date: Fri, 07 Mar 2008 12:01:05 -0500
Message-ID: <20080307170105.AF99E1A0039@mailserver8.hushmail.com>
Reply-To: postfail@hushmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-pm@lists.linux-foundation.org, power@bughost.org
List-Id: linux-pm@vger.kernel.org

I've seen several patch submissions and comments with varying
claims of 'power savings' from one level to another on both the 
linux-pm and powertop lists.

Standard technique seems to be to plug computer directly into a
wattmeter and then provide some feedback as to the savings comparing
one patchgroup to what is currently available.

Different wattmeters, however, will have different response and 
accuracy depending on load for instant readings; usually the lower-
loads (such as laptops) will be less accurate.

However, I have seen that most wattmeters do a 'better' job at 
measuring total wattage over an interval than the 'instant 
reading'. I advise caution in advertising 'expected savings' for 
instant readings....

Also, if anyone knows of any free benchmarks, best practices, or 
guidelines for trying to do comparative power analysis for patches 
with wattmeters please let me know.

---------------------------------------
Scott Thompson / postfail@hushmail.com
---------------------------------------
