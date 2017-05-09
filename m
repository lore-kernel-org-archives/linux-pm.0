From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 9 May 2017 09:29:03 +0200
Message-ID: <20170509072903.GA22559@pali>
References: <20170412230854.GA11963@fury>
 <201705082259.51850@pali>
 <77e4e46f58354e10874ed0515f514fc2@ausx13mpc120.AMER.DELL.COM>
 <201705090017.44210@pali>
 <3ceae37c323d43f8b1cf6c9aafe55d5e@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ceae37c323d43f8b1cf6c9aafe55d5e@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 09 May 2017 01:10:54 Mario.Limonciello@dell.com wrote:
> > 
> > I found dmsdos implementation of that DS compression at:
> > http://cmp.felk.cvut.cz/~pisa/dmsdos
> > 
> > Then took relevant decompression code and it really decompressed that
> > binary MOF WMI buffer. But still decompressed format is binary, but I
> > now see all WMI GUID encoded in UTF-16. Decompressed BMF file has again
> > "FOMB" magic header.
> 
> Well that's great.  Is it possible that this compression is used for every time
> a class was declared?

Looks like not. That decompressed output seems to be not compressed
anymore. Just use same magic header.

Now it looks like binary representation of MOF. Where structures and
types are encoded by binary sequences.

> > 
> > I pushed my decompression utility here:
> > https://github.com/pali/bmfdec
> 
> Did you forget another commit for pulling in arguments and opening a file
> or were you just putting the whole buffer into pin?

Whole BMF file should be on stdin (with that 16 bytes header) and is
decompressed on stdout.

> > 
> > So next step is to decode that decompressed binary MOF file.
> > 
> > > 44 53 looks promising to be quantum compression.

So... it is not Quantum compression. BMF content does not pass Quantum
header where is number of files (too huge).

-- 
Pali Rohár
pali.rohar@gmail.com
