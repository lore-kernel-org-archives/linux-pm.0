From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Building ACPI for PPC architecture
Date: Mon, 23 Oct 2006 09:43:12 -0600
Message-ID: <200610230943.13125.bjorn.helgaas@hp.com>
References: <200610230655.MAA16239@WS0005.indiatimes.com> <453C9B23.4020706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <453C9B23.4020706@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: rajeshprabhu72721 <rajeshprabhu72721@indiatimes.com>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 23 October 2006 04:36, Alexey Starikovskiy wrote:
> You should try to build ACPI CA interpreter in user-space for your architecture first.
> Get it here: http://www.intel.com/technology/iapc/acpi/downloads.htm
> There is a big chance that you will find too many endian issues.

That is certainly an issue.  I think HP-UX used to run the CA in
big-endian mode, so they probably sorted out some of the issues.
But I think it was an ongoing headache, so they finally gave up and
wrote wrappers to run the CA in little-endian mode while the rest
of the OS runs in big-endian mode.

Bjorn
