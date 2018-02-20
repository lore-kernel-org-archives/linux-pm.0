From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Timekeeping warning during resume from suspend to disk
Date: Tue, 20 Feb 2018 08:54:25 +0100
Message-ID: <20180220075425.GA13048@kroah.com>
References: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
Content-Disposition: inline
In-Reply-To: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Ivid Suvarna <ivid.suvarna@gmail.com>
Cc: Linux-pm@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 20, 2018 at 12:53:26PM +0530, Ivid Suvarna wrote:
> Hi All,
> 
> Facing below warning backtrace during resume from suspend to disk. I
> am using 4.1.15 freescale kernel.

4.1.15 is a kernel that is very old and obsolete (released almost 3
years ago, and tens of thousands of changes old.)  Please try something
newer and more modern like 4.15.  If the issue is still there, the
community will be glad to help you out.

If you are stuck at that old kernel version for some odd reason, please
get support from the company that is forcing you to use it.

good luck!

greg k-h
