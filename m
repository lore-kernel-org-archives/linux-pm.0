From: "Stoyan Gaydarov" <stoyboyker@gmail.com>
Subject: Re: [PATCH] ioctl conversion
Date: Fri, 11 Jul 2008 03:21:59 -0500
Message-ID: <6d291e080807110121t203c7cd0v9c84fb087cd75aa0__30076.5058062554$1215787167$gmane$org@mail.gmail.com>
References: <6d291e080807101728j62be7c93qba11aa214a8dfe1@mail.gmail.com>
	<200807111008.21497.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807111008.21497.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 11, 2008 at 3:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 July 2008, Stoyan Gaydarov wrote:
>> -       if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
>> +       lock_kernel();
>> +
>> +       if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC) {
>> +               unlock_kernel();
>>                 return -ENOTTY;
>> -       if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
>> +       }
>> +       if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR) {
>> +               unlock_kernel();
>>                 return -ENOTTY;
>> -       if (!capable(CAP_SYS_ADMIN))
>> +       }
>> +       if (!capable(CAP_SYS_ADMIN)) {
>> +               unlock_kernel();
>>                 return -EPERM;
>> +       }
>>
>>         data = filp->private_data;
>
> The more common way to express this is to end the function with
>
> out:
>        unlock_kernel();
>        return ret;
> }

This would work normally but there are three early returns and the
rest are just switch statements that set the return code.

>
> and then jump to that label in the error case. This makes it
> much easier to verify that you haven't missed a cased.
>
>        Arnd <><
>
