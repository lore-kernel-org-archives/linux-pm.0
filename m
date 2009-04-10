From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Regression: First hibernation attempt fails
Date: Fri, 10 Apr 2009 12:08:13 +0100
Message-ID: <49DF289D.5070604__34545.1630106711$1239361925$gmane$org@tuffmail.co.uk>
References: <49DDD83F.507@tuffmail.co.uk> <20090410092318.GB30093@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090410092318.GB30093@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Thu 2009-04-09 12:13:03, Alan Jenkins wrote:
>   
>> Yet another issue in 2.6.30-rc1 which was not present in 2.6.29 :-).  I
>> wonder if it rings any bells?
>>
>> On my laptop (EEE 4G), the first attempt at hibernation fails. 
>> Subsequent attempts succeed.
>>
>> If I use s2disk as normal, I see "snapshotting system", then before it
>> gets to write out the image, it aborts and switches back to X.   I can't
>> see any error message, even if I check the log with "dmesg".
>>
>> If I use "echo disk > /sys/power/state", echo reports the error "Cannot
>> allocate memory".
>>
>> This only happens if I've logged in to X first.  In fact, I narrowed it
>> down to gnome-power-manager.  If I kill gnome-power-manager beforehand,
>> then it doesn't happen.
>>     
>
> Anything interesting in dmesg?
>   

Nothing obvious. I've attached my latest at
<http://bugzilla.kernel.org/show_bug.cgi?id=13058>.

Regards
Alan
