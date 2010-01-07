From: mark gross <mgross@linux.intel.com>
Subject: Re: [RFC] PM_QOS api update to use handles 1/5
Date: Thu, 7 Jan 2010 12:55:58 -0800
Message-ID: <20100107205558.GB5703__25395.9127389409$1262897845$gmane$org@linux.intel.com>
References: <20091130010953.GA4732@mgross-laptop>
	<20100104083127.GA1450@ucw.cz>
	<20100106191132.GD21316@linux.intel.com>
	<20100106191831.GA3045@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100106191831.GA3045@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 640E9920 <640e9920@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 06, 2010 at 08:18:31PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Umm.. passing binary numbers like that... is not exactly good
> > > interface. Think endianness issues  when writing to it from high-level
> > > language.
> > 
> > yeah.  At the moment I can't recall why I went binary for the ABI, 
> > we can revisit this, but its been in the wild for a few years now :(
> > 
> > I guess I can do some tricks to see if its a hex string representation
> > of a number and parse that as well as supporting the s32.  i.e. accept
> > strings "0x0000000" ... "0xFFFFFFFF" and return -EINVAL for anything
> > else.
> 
> Maybe you could use length for detection? If they are writing 4 bytes,
> it is s32, 10 bytes means ascii?

That is what I was thinking + making sure the chars in the string where
valid hex digits ;)  It would be easy to do.  Let me know if you think I
should attempt to roll that into the kernel ABI exposed by this thing.

--mgross
