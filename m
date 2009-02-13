From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Thu, 12 Feb 2009 16:38:27 -0800
Message-ID: <d6200be20902121638t62687ec6k6fc39055a41a78fa@mail.gmail.com>
References: <1234316955-31304-3-git-send-email-arve@android.com>
	<1234316955-31304-5-git-send-email-arve@android.com>
	<1234316955-31304-6-git-send-email-arve@android.com>
	<1234316955-31304-7-git-send-email-arve@android.com>
	<1234316955-31304-8-git-send-email-arve@android.com>
	<1234316955-31304-9-git-send-email-arve@android.com>
	<1234316955-31304-10-git-send-email-arve@android.com>
	<20090212113126.GC28176@srcf.ucam.org>
	<d6200be20902121627k7ea21f21hba24a2616e27aa42@mail.gmail.com>
	<20090213003402.GA8393@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213003402.GA8393@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 12, 2009 at 4:34 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Thu, Feb 12, 2009 at 04:27:53PM -0800, Arve Hj=F8nnev=E5g wrote:
>> On Thu, Feb 12, 2009 at 3:31 AM, Matthew Garrett <mjg59@srcf.ucam.org> w=
rote:
>> > On Tue, Feb 10, 2009 at 05:49:14PM -0800, Arve Hj=F8nnev=E5g wrote:
>> >
>> >>       spin_lock(&client->buffer_lock);
>> >> +     wake_lock_timeout(&client->wake_lock, 5 * HZ);
>> >
>> > Why the timeout version? If your input handler vanishes for more than 5
>> > seconds then presumably you should be thinking about watchdoging the
>> > entire system.
>>
>> The timeout allows the system to eventually suspend if someone opened
>> the input device and but are not reading from it. We hit this once. I
>> can remove the timeout, but these bugs are more visible in the stats
>> if we keep timeout since the expire counts will be non-zero.
>
> Mm. I'm not convinced about kernel behaviour that's designed to work
> around userspace failures. The assumption that your input consumer will
> act within 5 seconds is a policy decision, so should probably be left to
> userspace.

I can make it a module param. I still need a default. I considering 0
(no wakelock), 5 seconds or infinite.

-- =

Arve Hj=F8nnev=E5g
