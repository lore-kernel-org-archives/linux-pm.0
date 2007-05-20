From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Sun, 20 May 2007 22:39:08 +0200
Message-ID: <4650B1EC.4080903__2215.28328625045$1179693679$gmane$org@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>
	<20070518082821.230dd4c5.akpm@linux-foundation.org>
	<464DDB85.7080203@s5r6.in-berlin.de>
	<tkrat.a98b66b055229e9d@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.a98b66b055229e9d@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I wrote:
> Could you test the following patch?  I don't have a machine to test it
> myself at the moment but may have one tonight or tomorrow.

Sorry.  I tried with a new ACPI PC and and old APM notebook.  The former
does not resume after s2ram (screen remains blank after resume), and the
latter has a serious bug in APM resume under 2.6.22-rc2 (without
FireWire drivers loaded but with some other drivers present; it resumes
but anything I do quickly locks up, even "dmesg").

I will try to get 2.6.21 or .20 plus backports of the new FireWire
drivers set up on the APM notebook during next week.  But I'd appreciate
if you could test the patch from my previous post.
-- 
Stefan Richter
-=====-=-=== -=-= =-=--
http://arcgraph.de/sr/
