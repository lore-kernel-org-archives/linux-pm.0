From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Mon, 13 Dec 2010 11:04:34 +0100
Message-ID: <4D05EFB2.3050703__3623.2978025966$1292234838$gmane$org@gmail.com>
References: <201012030107.oB317ZSW019223@imap1.linux-foundation.org>
	<4CFB4C66.1090106@gmail.com> <201012051408.27730.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012051408.27730.rjw@suse.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 12/05/2010 02:08 PM, Rafael J. Wysocki wrote:
> On Sunday, December 05, 2010, Jiri Slaby wrote:
>> On 12/03/2010 01:34 AM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2010-12-02-16-34 has been uploaded to
>>
>> Hi, this kernel regresses with respect to resume. It doesn't wake up,
>> the screen is black with blinking cursor at position [1, 1].
>> 2010-11-23-16-12 seemed to be OK. In this one it is 100% reproducible so
>> far.
>>
>> I'm using pm-suspend, any ideas what to test before I start to find the
>> reason on my own?
> 
> Please try the pm_test tests for core, processors and devices, eg.:

Hmm, I haven't seen the issues since then. So it had to be some kind of
coincidence -- I see the issue occasionally for some time already. Now
it triggered twice in a row after I updated the kernel.

regards,
-- 
js
