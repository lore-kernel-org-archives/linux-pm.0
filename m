From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 2.6.32-rc1: various BUGs on resume from hibernation
Date: Mon, 05 Oct 2009 21:02:37 +0100
Message-ID: <4ACA50DD.9050801@tuffmail.co.uk>
References: <4AC8B4A8.3050601@tuffmail.co.uk>	<4AC8D568.9090103@tuffmail.co.uk>	<200910042247.43528.rjw@sisk.pl>
	<20091005095327.5ea9831b@strolchi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091005095327.5ea9831b@strolchi>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Stefan Seyfried wrote:
> On Sun, 4 Oct 2009 22:47:43 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>   
>> On Sunday 04 October 2009, Alan Jenkins wrote:
>>     
>>> Alan Jenkins wrote:
>>>       
>>>> I'm seeing a variety of BUGs on my EeePC 701 after hibernation.  
>>>> Sometimes they cause a hang during resume; sometimes they happen
>>>> just after resume.  It doesn't happen all the time either -  I've
>>>> just hibernated three times in a row with no problems.  It's most
>>>> perplexing.
>>>>         
>
>   
>> As I already asked in the Bugzilla, can you verify that this is
>> reproducible without KMS?
>>     

No. I couldn't reproduce it without KMS. Then I re-enabled KMS, 
hibernated a couple of times, and had another resume hang (different 
again - this time in the freezer).
