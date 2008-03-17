From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Metrics for comparing power savings of patches...
Date: Mon, 17 Mar 2008 08:50:36 -0700
Message-ID: <47DE934C.9020901__8925.87745697728$1205769331$gmane$org@linux.intel.com>
References: <20080307170105.AF99E1A0039@mailserver8.hushmail.com>
	<20080316190341.GA4638@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080316190341.GA4638@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Scott Thompson <postfail@hushmail.com>, power@bughost.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
>> However, I have seen that most wattmeters do a 'better' job at 
>> measuring total wattage over an interval than the 'instant 
>> reading'. I advise caution in advertising 'expected savings' for 
>> instant readings....
>>
>> Also, if anyone knows of any free benchmarks, best practices, or 
>> guidelines for trying to do comparative power analysis for patches 
>> with wattmeters please let me know.
> 
> Intel has something on lesswatts.org.

the most "accurate" method is "minutes before the battery is empty" as long
as you do measurements shortly after eachother on the same battery and take care
of how full the battery is charged when you start the rundown.

However.. this takes forever to do any kind of experiment.
