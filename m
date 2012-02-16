From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: Corrupted files after suspend to disk
Date: Fri, 17 Feb 2012 00:37:17 +0100
Message-ID: <CAFLxGvz4MUQrLUs=CWVbWspKQoBC7qiLTUyWQMKzgeX8r3L8VA@mail.gmail.com>
References: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com>
	<AANLkTinewk=mJZifVxEJkCtKfNauOjHnLAqwbGn139C=@mail.gmail.com>
	<AANLkTikui_HQ5JMcMJUqMr9WLyTRNzF-z4G7wAUNPOFy@mail.gmail.com>
	<201103242330.14416.rjw@sisk.pl>
	<CAFLxGvzzHDRma_Y_XEpOD+fY+vonbkoR1mvQp4Vb4c3M6fTsPA@mail.gmail.com>
	<20120216163030.GA32651@redhat.com> <4F3D90E1.6010001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F3D90E1.6010001@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, esandeen@redhat.com
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 17, 2012 at 12:27 AM, Eric Sandeen <sandeen@redhat.com> wrote:
> On 2/16/12 8:30 AM, Dave Jones wrote:
>> On Thu, Feb 16, 2012 at 11:52:27AM +0100, richard -rw- weinberger wrote:
>>
>> =A0> >> >> Of course, please test the above separately. :-)
>> =A0> >> >
>> =A0> >> > Ok, I'll test this when I'm at home.
>> =A0> >> >
>> =A0> >> > BTW: dropping the caches helps, when some files seem corrupted.
>> =A0> >> > Today /usr/bin/okular was broken.
>> =A0> >> > After setting vm.drop_caches=3D1 it worked again.
>> =A0> >>
>> =A0> >> On Linux 2.6.38 I'm unable to reproduce the issue.
>> =A0> >> Only 2.6.37 seems to be affected.
>> =A0> >> So, I'm moving over to 2.6.38. :)
>> =A0> >
>> =A0> Bad news:
>> =A0> I saw the issue on 3.x too but thought it's because my IdeaPad s10 =
is crap.
>> =A0> Now with my shiny new Lenovo x121e I have the same issue! :-(
>> =A0>
>> =A0> OpenSUSE 12.1, kernel 3.2.7.
>> =A0> After a few suspend2disk iterations random files are corrupted.
>> =A0> But only cached files. A reboot solves the problem.
>
> Just to be clear - you see _data_ corruption in files, but only
> until a reboot, and after that they are ok? =A0Ok, reading above
> about using drop_caches that sounds like the case.

Yes.
A reboot always solved the data corruption.
drop_caches solved it in 99% of all cases.

On-disk data was never corrupted.

-- =

Thanks,
//richard
