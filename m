From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Fri, 6 Feb 2009 16:47:59 -0800
Message-ID: <d6200be20902061647m4ca6e7bape70fe4b67685746c@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<20090206001020.GC19577@linux.intel.com>
	<d6200be20902051638p37fb012do8e0aad0e67cf4305@mail.gmail.com>
	<20090207003334.GA13923@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090207003334.GA13923@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 6, 2009 at 4:33 PM, mark gross <mgross@linux.intel.com> wrote:
>> >> +#ifdef CONFIG_WAKELOCK_STAT
>> >> +     create_proc_read_entry("wakelocks", S_IRUGO, NULL,
>> >> +                             wakelocks_read_proc, NULL);
>> >
>> > Shouldn't we *not* be using /proc?  I think this should be under sysfs.
>>
>> It is not allowed under sysfs. Debugfs has been suggested, but we
>> don't have debugfs mounted, and we include the wakelock stats in debug
>> reports.
>>
>
> why not under sysfs?

The rules for sysfs state that there should be one value or an array
of values per file.

-- =

Arve Hj=F8nnev=E5g
