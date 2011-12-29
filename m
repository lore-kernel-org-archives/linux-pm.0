From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] PM / Hibernate: Improve performance of
 LZO/plain hibernation, checksum image
Date: Thu, 29 Dec 2011 10:37:24 +0800
Message-ID: <CAGsJ_4xH-9MXq8UJJFLW=upBqK+PXbWfDJhttBN=n2_M0PzMSw@mail.gmail.com>
References: <CAGsJ_4yXU62GZ38fe7TCH8uKLHJvZ8jtFbJLywqv1kgC7y9V_A@mail.gmail.com>
	<1325115628.2029.1.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1325115628.2029.1.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>
List-Id: linux-pm@vger.kernel.org

2011/12/29 Bojan Smojver <bojan@rexursive.com>:
> On Tue, 2011-12-27 at 20:27 +0800, Barry Song wrote:
>> this patch is definitely great!
>
> Thanks, I'm glad you liked it.
>
>> any plan to write the same patch for decompress and restore? i think
>> that is probably more important than compression and hibernation to
>> improve bootup speed.
>
> I'm not sure I understand what you mean here. Can you elaborate?

i mean we can load image and decompress them in different threads when
we reboot from hibernation.
after i read codes more carefully, that has actually been done by
lzo_decompress_threadfn().

here the problem is we didn't seem to get any faster after applying
your compression patch when doing hibernation on SD/NAND.
we are trying to figure out the reason.

>
> --
> Bojan
>

-barry
