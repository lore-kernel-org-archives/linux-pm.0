From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 09/10] Input: Hold wake lock while event
	queue is not empty.
Date: Thu, 12 Feb 2009 16:27:53 -0800
Message-ID: <d6200be20902121627k7ea21f21hba24a2616e27aa42@mail.gmail.com>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<1234316955-31304-3-git-send-email-arve@android.com>
	<1234316955-31304-4-git-send-email-arve@android.com>
	<1234316955-31304-5-git-send-email-arve@android.com>
	<1234316955-31304-6-git-send-email-arve@android.com>
	<1234316955-31304-7-git-send-email-arve@android.com>
	<1234316955-31304-8-git-send-email-arve@android.com>
	<1234316955-31304-9-git-send-email-arve@android.com>
	<1234316955-31304-10-git-send-email-arve@android.com>
	<20090212113126.GC28176@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090212113126.GC28176@srcf.ucam.org>
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

On Thu, Feb 12, 2009 at 3:31 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Tue, Feb 10, 2009 at 05:49:14PM -0800, Arve Hj=F8nnev=E5g wrote:
>
>>       spin_lock(&client->buffer_lock);
>> +     wake_lock_timeout(&client->wake_lock, 5 * HZ);
>
> Why the timeout version? If your input handler vanishes for more than 5
> seconds then presumably you should be thinking about watchdoging the
> entire system.

The timeout allows the system to eventually suspend if someone opened
the input device and but are not reading from it. We hit this once. I
can remove the timeout, but these bugs are more visible in the stats
if we keep timeout since the expire counts will be non-zero.

-- =

Arve Hj=F8nnev=E5g
