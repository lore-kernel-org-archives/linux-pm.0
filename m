From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM: HIBERNATION: skip the swap size check
	if the snapshot image size is anticipative
Date: Mon, 9 Jan 2012 22:46:34 +0100
Message-ID: <201201092246.35170.rjw@sisk.pl>
References: <1322208422-12346-1-git-send-email-Barry.Song@csr.com>
	<201201082231.44510.rjw@sisk.pl>
	<CAGsJ_4y+fQ14yDzD1FxtutD7b17KqK+voaywHAZuS0SXK5Z_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGsJ_4y+fQ14yDzD1FxtutD7b17KqK+voaywHAZuS0SXK5Z_xQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Barry Song <21cnbao@gmail.com>
Cc: Xiangzhen Ye <Xiangzhen.Ye@csr.com>, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 09, 2012, Barry Song wrote:
> 2012/1/9 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Friday, January 06, 2012, Barry Song wrote:
> >> 2012/1/6 Pavel Machek <pavel@ucw.cz>:
> >> > Hi!
> >> >
> >> > Is the check even useful these days? Should we remove it altogether?
> >>
> >> i think we can let users or distributions decide whether it is useful.
> >> On PC, disk space is not an issue, people might run many applications
> >> while doing hibernation, so snapshot is much big. an early check will
> >> improve user experience because people don't need to wait a long time
> >> and find space is not enough.
> >> for embedded system, SoC solutions can know whether the space is
> >> enough since they know what are running while doing hibernation, so
> >> they can skip the check by setting the flag in sysfs.
> >> that is why i had this patch sent.
> >
> > I agree with Pavel that it's better to drop the check altogether.
> >
> > The sysfs switch you're adding doesn't seem to be very useful, as PC
> > users won't touch it and whoever needs it to be 0, will always set it
> > that way and won't change it afterwards.
> 
> ok. if we don't have the check, in case swap partition is not enough,
> writing failure will happen, system still can restore to normal
> status:
> 
> for example, in the following test, only 27% data is written with a
> small partition, "Restarting tasks ... done" will make system restore
> to normal status.
> 
> [   11.2080 27%
> [   11.403274] PM: Wrote uncompressed 34920 kbytes in 0.65 seconds (53.72 MB/s)
> [   11.407649] PM: Wrote compressed 3500 kbytes in 0.65 seconds (5.38 MB/s)
> [   11.447176] Restarting tasks ... done.
> [   11.448801] ...

That's exactly correct.

Thanks,
Rafael
