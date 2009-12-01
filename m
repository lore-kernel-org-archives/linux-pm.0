From: Lior Dotan <liodot@gmail.com>
Subject: Re: Linux 2.6.32-rc8 - T500 fails to suspend to RAM
Date: Tue, 01 Dec 2009 23:58:38 +0200
Message-ID: <4B15918E.4000200__7665.73991063542$1259869599$gmane$org@gmail.com>
References: <4B151FE2.3090807@gmail.com> <200912012246.58383.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912012246.58383.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday 01 December 2009, Lior Dotan wrote:
>   
>> Hi,
>>
>> Ever since I've upgraded to rc8, my T500 fails to suspend to RAM for the
>> second time. Suspending for the first time works ok but when I resume and
>> later try to suspend again the screen gets blank and the moon LED blinks
>> forever. rc6 & rc7 as well as 2.6.31 worked great with out a problem.
>>     
>
> Well, I don't see any particular change that might cause the symptoms you
> describe between -rc7 and -rc8.  If this is 100% reproducible, I guess
> bisecting is the only option at the moment.
>   
It is very easy to reproduce, I will try to bisect it.
